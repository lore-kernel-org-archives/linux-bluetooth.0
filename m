Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed API
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <201005041254.37990.jcaden@libresoft.es>
Date: Tue, 4 May 2010 21:07:24 -0300
Cc: Santiago Carot-Nemesio <scarot@libresoft.es>,
	linux-bluetooth@vger.kernel.org
Message-Id: <414EAFF0-4D91-488E-A19B-E0B063487B7D@signove.com>
References: <1272959741.2182.123.camel@mosquito> <m2u2d5a2c101005040304ke238595n54b8584dd78b8f37@mail.gmail.com> <201005041254.37990.jcaden@libresoft.es>
To: jcaden@libresoft.es
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> while some_condition:
> 	try:
> 		os.write(fd, "some_data")
> 	except:
> 		fd = dev.GetDcFd(dcid) # Implicit reconeciton of dc

I'd like to believe that power-saving disconneciton of a L2CAP channel and reconnection would be that simple to handle at application side. But I don't :)

Even if the fd is a L2CAP SOCK_SEQPACKET, which means that write() would be atomic for the message, the message might be still at output buffer when the connection drops. Or it might have been transmitted. The application would never know, and could not act upon.

I think that, talking specifically about this MCAP/HDP data channel reconnection stuff, we have two extremist albeit sensible approaches:

a) let the application handle it, as "my" API proposes. Application is notified about disconnection and chooses what to do, and lingering sessions must be prepared to deal with FD replacement;

b) hide it completely from the application. This includes NOT passing the L2CAP fd, but a UNIX socket fd which HDP plug-in takes care of. Or, perhaps not to use any FD passing at all: just send HDP data messages via D-BUS, and that's it.

Your API has a mix of "a" and "b": approaches: automatic reconnection but with possible mid-flight FD replacement.