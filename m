Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] General Debian bluez question
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1106956484.11673.213836256@webmail.messagingengine.com>
References: <1106956484.11673.213836256@webmail.messagingengine.com>
Content-Type: text/plain
Message-Id: <1106962292.10580.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 29 Jan 2005 02:31:32 +0100

Hi Russell,

> I am hoping someone can answer a general Debian-bluez question.
> 
> I have installed Debian sarge and upgraded to the sid kernel so I can
> apply the patch patch-2.6.10-mh2.gz.
> 
> When installing sarge I also choose the bluez-utils package, but there
> is another package called kernel-patch-2.6-bluez. Should I also be
> patching the 2.6.10 kernel with this patch, as well as the "mh2" one?

I don't know what kernel-patch-2.6-bluez is, ask the maintainer. The
only official patch is the -mh patch.

> My Microsoft bluetooth mouse works fine without the debian patch - or at
> least it seems to! I'm just curious about whether I need both patches. I
> will continue to use the "mh2" patch do I can enjoy scroll-wheel
> support.

The -mh2 will give you report mode protocol support and this means the
scroll wheel should be useable.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
