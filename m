Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Frederic Dalleau <frederic.dalleau@access-company.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20070721225221.GA2092@rapidpacket.com>
References: <20070721225221.GA2092@rapidpacket.com>
Date: Wed, 25 Jul 2007 14:22:36 +0200
Message-Id: <1185366156.2745.24.camel@ubuntu.mpl.access-company.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] a2dpd:
	stream_client_send_pointer_resp:	(errno=32:Broken pipe)Error
	while sending data
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

The link between the alsa plugin and a2dpd seems broken.
You can modify .asoundrc as follow to get more informations

pcm.yourpluginnamehere {
	type a2dpd
	debug 255
}

Trying another player might help.

Frederic


On Sat, 2007-07-21 at 17:52 -0500, Todd Troxell wrote:
> Hello,
> 
> I'm connecting latest CVS a2dpd to an Alpine KCA100BT.  It connects ok, pin
> exchange ok, but when it starts to stream, I get:
> 
> A2DPD[16:37:05.324]: pollfd_cb_avrcpfd: socket 13: Connection from
> 31:98:D1:55:0C:00, mtu=610 accepted at index 0
> A2DPD[16:37:06.288]: stream_client_send_pointer_resp: (errno=32:Broken
> pipe)Error while sending data^M
> A2DPD[16:37:06.288]: disconnect_client:
> 
> Full debug log is attached.  Let me know if you'd like any further data.
> 
> Thanks,
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________ Bluez-devel mailing list Bluez-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
