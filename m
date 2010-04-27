Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Apr 2010 22:20:59 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: ofono@ofono.org,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: DUN client for oFono and BlueZ
Message-ID: <20100427012059.GG12813@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm starting the DUN Client implementation for the Linux Stack. DUN is
the Bluetooth dial-up network profile. It makes possible share internet
connection between two Bluetooth devices. That is my Google Summer of Code
project for this year.

Here follows a simple, and possible not complete, roadmap:

1. Put send_method_call() and send_method_call_with_reply() on gdbus: those
functions are very useful for DBus operations. You can send a DBus message
just calling them with the right parameters. Patch for that work already 
on the mailing list.

2. Create a bluetooth.c file with the bluetooth helpers. oFono plugins for HFP,
DUN and SAP will be able to share the same bluetooth code to access BlueZ
stuff. This is a ongoing work.

3. plugin/dun.c prototype. A simple prototype for the DUN client.

4. Agent server on BlueZ. This one is very similar to the HFP Agent server. At
the end of the DUN agent project I plan to merge the both agent servers. SAP
will take advantage of that merge too.

5. oFono DUN agent. Implement the agent handling for DUN.

6. AT command parser and PPP stack integration with DUN. The biggest task,
where the core of the project is.

7. ConnMan integration. Setup of the NAT and Internet Connections.


Comments are welcome. :)

-- 
Gustavo F. Padovan
http://padovan.org
