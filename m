Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Mon, 26 Apr 2010 23:12:06 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: ofono@ofono.org,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: DUN client for oFono and BlueZ
Message-ID: <20100427021206.GI12813@vigoh>
References: <20100427012059.GG12813@vigoh>
 <1272334033.22838.117.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272334033.22838.117.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2010-04-27 04:07:13 +0200]:

> Hi Gustavo,
> 
> > I'm starting the DUN Client implementation for the Linux Stack. DUN is
> > the Bluetooth dial-up network profile. It makes possible share internet
> > connection between two Bluetooth devices. That is my Google Summer of Code
> > project for this year.
> > 
> > Here follows a simple, and possible not complete, roadmap:
> > 
> > 1. Put send_method_call() and send_method_call_with_reply() on gdbus: those
> > functions are very useful for DBus operations. You can send a DBus message
> > just calling them with the right parameters. Patch for that work already 
> > on the mailing list.
> > 
> > 2. Create a bluetooth.c file with the bluetooth helpers. oFono plugins for HFP,
> > DUN and SAP will be able to share the same bluetooth code to access BlueZ
> > stuff. This is a ongoing work.
> > 
> > 3. plugin/dun.c prototype. A simple prototype for the DUN client.
> > 
> > 4. Agent server on BlueZ. This one is very similar to the HFP Agent server. At
> > the end of the DUN agent project I plan to merge the both agent servers. SAP
> > will take advantage of that merge too.
> > 
> > 5. oFono DUN agent. Implement the agent handling for DUN.
> > 
> > 6. AT command parser and PPP stack integration with DUN. The biggest task,
> > where the core of the project is.
> 
> this is pretty clear. oFono carries the GAtChat library that comes with
> AT command and PPP support. So oFono should carry the DUN client.

Absolutely, I forgot to mention that oFono should carry the DUN client. I'm
starting some working on it. I'll send patches soon. :)

Regards,


-- 
Gustavo F. Padovan
http://padovan.org
