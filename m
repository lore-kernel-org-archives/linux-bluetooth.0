Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: pkicad@yahoo.es, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200709201335.29616.pkicad@yahoo.es>
References: <200709201335.29616.pkicad@yahoo.es>
Date: Fri, 21 Sep 2007 10:44:48 +0200
Message-Id: <1190364288.5133.21.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Permission denied: hcitools
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Pedro,

> Sorry if the topic has been aswered, but I have not found it in the 
> bluez-users archives.
> 
> When trying some hcitools, I am unable to use them  but being root. I want to 
> run them as a "normal" user.
> 
> Is there any group the user needs to belong to or any other way to have 
> privileges on hcitools, hcidump, l2ping, etc?

if you don't wanna use them as root, then don't use them at all. It is
really as simple as that. The new D-Bus based interface should be used
anyway.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
