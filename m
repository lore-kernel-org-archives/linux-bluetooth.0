Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Stockwell <dstockwell@frequency-one.com>
In-Reply-To: <01f601c8bc66$13fd69c0$6701a8c0@freqonedev>
References: <01d801c8bc5a$027798d0$6701a8c0@freqonedev>
	<D0DBF0CD-7285-47DF-ACD9-9F1F23A58BD2@holtmann.org>
	<01f601c8bc66$13fd69c0$6701a8c0@freqonedev>
Message-Id: <1D8657D1-D804-43B5-8FEE-D8E3B4A52869@holtmann.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 23 May 2008 01:53:39 +0200
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problems with returning Default Adapter in
	C-Glib-DBus code
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

Hi David,

> Actually, I did that...I think.
>
> Please review the following call:
>
> if (dbus_g_proxy_call(dMgrObj, "DefaultAdapter", &dError,  
> G_TYPE_INVALID, G_TYPE_OBJECT, &servicePath, G_TYPE_INVALID)) {
>  cout << "DefaultAdapter is " << servicePath << endl;
> } else {
>  if (dError!=NULL) {
>   cout << "Failed to get DefaultAdapter: " << dError->message << endl;
>   g_error_free(dError);
>   return EXIT_FAILURE;
>  }
> }
>
> The G_TYPE_OBJECT should mark the return value (stuffed into a char  
> * servicePath) as an Object Path. Or am I mistaken?

the type is an DBUS_G_OBJECT_PATH or similar.

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
