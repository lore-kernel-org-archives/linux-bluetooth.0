Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Boot Protocol Problem with Microsoft Keyboard/Mouse
Message-ID: <20051009105913.GD954@polar.elf12.net>
References: <4348E48C.5070305@darkmetatron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4348E48C.5070305@darkmetatron.de>
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
Date: Sun, 9 Oct 2005 12:59:13 +0200

On Sun, Oct 09, 2005 at 11:36:12AM +0200, Sebastian Beßler wrote:
> Hello,
> 
> I bought myself the Microsoft Optical Desktop Elite for Bluetooth
> Package with Keyboard and Mouse and now I have the Problem that it is
> only recognized as a Boot Protocol Device
> 
> DarkMetatron metatron # hidd
> 00:0D:3A:A2:92:28 HID Boot Device [045e:0099] connected [boot-protocol]

Patch the kernel. Stock kernels have only boot-protocol support.



Robert


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
