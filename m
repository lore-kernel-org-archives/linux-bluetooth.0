Return-Path: <cyrus@holtmann.org>
Message-Id: <2AED3B35-DD76-423F-945A-42543C41D699@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY107-W1580ABAE4B060A2CC0ADECD8340@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Mon, 28 Jan 2008 19:06:28 +0100
References: <BAY107-W1580ABAE4B060A2CC0ADECD8340@phx.gbl>
Subject: Re: [Bluez-devel] inquiry with RSSI (not via d-bus & python)
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

Hi Adolfo,

> Hi guys, I'm trying to setup an inquiry with RSSI. So far in hci.c  
> there is no hci_inquiry_with_RSSI function, infact the *inquiry_info  
> returned is a normal inquiry_info struct (without the rssi value).  
> How can I perform an inquiry with rssi operation??
> I don't want to use python and d-bus because i have already a C  
> native library linked to my java program via JNI, and i don't want  
> to mix-up things furthermore. Do you know some code snippet  
> performing similar operations? (unfortunately i'm not very good in C  
> programming :( )

before considering using libbluetoth to link against JNI or other  
libraries/applications, please be sure that it complies with GPL  
license.

The D-Bus version is the current version to do an inquiry. This  
ensures that everything works properly. Handling all the inquiry  
result differences between Bluetooth 1.1, 1.2 and 2.1 versions is  
complicated enough and has been solved within the D-Bus API.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
