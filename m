Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1193591164.4724c17c545eb@imp.free.fr>
References: <1193591164.4724c17c545eb@imp.free.fr>
Date: Sun, 28 Oct 2007 19:16:22 +0100
Message-Id: <1193595382.5096.15.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH 1/3] move common exceptions to
	common/	directory
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

Hi Fabien,

> This is the first patch for what i have in mind for the dbus errors management:
>  - org.bluez.Error.xxx : generic errors used by hcid and all services, declared
> in common-error.h
>  - org.bluez.Error.SERVICENAME.yyy : errors that have a meaning only to a local
> service.
>  - org.bluez.core.Error.zzz : errors that have a meaning local to hcid, not
> shared with other services.

I like to have org.bluez.Error only. There is no need to get an extra
hierarchy level.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
