Return-Path: <cyrus@holtmann.org>
From: "Zhang, Zhenhua" <zhenhua.zhang@intel.com>
To: "ofono@ofono.org" <ofono@ofono.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 27 Apr 2010 10:14:38 +0800
Subject: RE: DUN client for oFono and BlueZ
Message-ID: <33AB447FBD802F4E932063B962385B351D9FDF3B@shsmsx501.ccr.corp.intel.com>
References: <20100427012059.GG12813@vigoh>
In-Reply-To: <20100427012059.GG12813@vigoh>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Padovan,

Gustavo F. Padovan wrote:
> Hi all,
> 
> I'm starting the DUN Client implementation for the Linux
> Stack. DUN is the Bluetooth dial-up network profile. It makes
> possible share internet connection between two Bluetooth
> devices. That is my Google Summer of Code project for this year.
> 
> Here follows a simple, and possible not complete, roadmap:
> 
> 1. Put send_method_call() and send_method_call_with_reply() on
> gdbus: those functions are very useful for DBus operations.
> You can send a DBus message just calling them with the right
> parameters. Patch for that work already on the mailing list.
>
> 2. Create a bluetooth.c file with the bluetooth helpers. oFono
> plugins for HFP, DUN and SAP will be able to share the same
> bluetooth code to access BlueZ stuff. This is a ongoing work.

Is this bluetooth.c like a utility to watch BlueZ status, watch adapter change and signals? If I understand correctly, every plugin like HFP, DUN, SAP will add status callback for different event.

> 3. plugin/dun.c prototype. A simple prototype for the DUN client.

Not quite sure whether we need this. Denis suggests to create an Emulator atom in the ofono core. I am now making a prototype to create this atom in oFono.
The structure is similar to voicecall.c. An emulator manager could create HFP AG, DUN or SPP type emulators. When one is created, other atom get notified and register their interested AT command handers to GAtServer. So in this way, agent server on BlueZ may call oFono CreateEmulator method and pass file descriptor directly to oFono.

> 4. Agent server on BlueZ. This one is very similar to the HFP
> Agent server. At the end of the DUN agent project I plan to
> merge the both agent servers. SAP will take advantage of that merge
> too. 
> 
> 5. oFono DUN agent. Implement the agent handling for DUN.

Actually, my original prototype is quite simliar with yours. DUN, HFP and SPP are implemented as plugins. See my previous patches in the mailing list for details.

> 6. AT command parser and PPP stack integration with DUN. The
> biggest task, where the core of the project is.

GAtServer and PPP are already there. We still need to add DUN specific command and callbacks.

> 7. ConnMan integration. Setup of the NAT and Internet Connections.
> 
> 
> Comments are welcome. :)
> 
> --
> Gustavo F. Padovan
> http://padovan.org
> _______________________________________________
> ofono mailing list
> ofono@ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua

