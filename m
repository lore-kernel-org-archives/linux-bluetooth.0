Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: HDP proposed API
Date: Wed, 5 May 2010 12:57:20 +0200
Cc: "Santiago Carot-Nemesio" <scarot@libresoft.es>,
	linux-bluetooth@vger.kernel.org
References: <1272959741.2182.123.camel@mosquito> <201005041254.37990.jcaden@libresoft.es> <414EAFF0-4D91-488E-A19B-E0B063487B7D@signove.com>
In-Reply-To: <414EAFF0-4D91-488E-A19B-E0B063487B7D@signove.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005051257.20525.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Wednesday 05 May 2010 02:07:24 Elvis Pfützenreuter escribió:
> 
> > while some_condition:
> > 	try:
> > 		os.write(fd, "some_data")
> > 	except:
> > 		fd = dev.GetDcFd(dcid) # Implicit reconeciton of dc
> 
> I'd like to believe that power-saving disconneciton of a L2CAP channel and reconnection would be that simple to handle at application side. But I don't :)
> 
> Even if the fd is a L2CAP SOCK_SEQPACKET, which means that write() would be atomic for the message, the message might be still at output buffer when the connection drops. Or it might have been transmitted. The application would never know, and could not act upon.
> 
> I think that, talking specifically about this MCAP/HDP data channel reconnection stuff, we have two extremist albeit sensible approaches:

We think that this is an important issue and you are right, we didn't thought about the 
buffers and could be a problem because dbus fd passing could be buffering the data.
We based our design in AUDIO plugin that uses fd passing too.

> 
> a) let the application handle it, as "my" API proposes. Application is notified about disconnection and chooses what to do, and lingering sessions must be prepared to deal with FD replacement;

Here you have the same problem that you mentioned above, because you don't know
 what data was send, you also have the fd passing problem and you don't know the
 amount of data that was sent. 

> 
> b) hide it completely from the application. This includes NOT passing the L2CAP fd, but a UNIX socket fd which HDP plug-in takes care of. Or, perhaps not to use any FD passing at all: just send HDP data messages via D-BUS, and that's it.

We prefer this and we thought about it in the past. There are a little bit more complicated
but probably safer.

The d-bus writing option: we thing that is too much load for the dbus and that will be very
slow too. Because the change to xml formtat could be very expensive, and the amount of data
could be very big. Note tha 11073-20601 defines apdus of 65Kb (we think that this is too much for d-bus)

The option of having a socket sounds a little bit complicated, but we think that it is the best.
We also thought about it in the past but we discarted it because it is harder to implement it 
than the fd-passing option (we didn't see the problems that you mentioned). In fact, the 
no-bluez-integrated implementation that we did in the past used this method.

I think having an HDP socket is great because reconnections can be implicit for the upper layers
that can see the socket as permantly connected even when it is closed. HDP should 
reconenct when receives data from the client to send to the remote device. This way no data
can be lost and reconnections  are implicit. An other advantage of this option is that the 
upper aplication doesn't have any aditional load with the reconnection issue.


> 
> Your API has a mix of "a" and "b": approaches: automatic reconnection but with possible mid-flight FD replacement.--


Regards
