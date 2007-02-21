Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45DC5C3C.4070002@odi.ch>
References: <45DC5C3C.4070002@odi.ch>
Date: Wed, 21 Feb 2007 16:08:05 +0100
Message-Id: <1172070485.7403.29.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] boot vs. report protocol
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Ortwin,

> In net/bluetooth/core.c there is:
> 
> 	if (session->input) {
> 		hidp_send_ctrl_message(session,
> 			HIDP_TRANS_SET_PROTOCOL | HIDP_PROTO_BOOT, NULL, 0);
> 		session->flags |= (1 << HIDP_BOOT_PROTOCOL_MODE);
> 
> 		session->leds = 0xff;
> 		hidp_input_event(session->input, EV_LED, 0, 0);
> 	}
> 
> 
> which effectively sets the boot protocol for all input devices. To
> support some scroll wheel mice they need to be put into report mode, though:
> 
> 	if (session->input) {
> 		hidp_send_ctrl_message(session,
> 			HIDP_TRANS_SET_PROTOCOL | HIDP_PROTO_REPORT, NULL, 0);
> 
> 		session->leds = 0xff;
> 		hidp_input_event(session->input, EV_LED, 0, 0);
> 	}
> 
> I assume that's safe. Solaris for instance, initializes all devices in
> report mode by default. It never even tries boot protocol.

you assumption is wrong. The flags variable doesn't change anything. You
might wanna try 2.6.20-mh1 which is the first one that includes the
official report mode support.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
