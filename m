Return-Path: <cyrus@holtmann.org>
Message-Id: <944126E1-548D-4EF1-88A6-8505A42E17E3@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <01e501c8bc60$e20638c0$6701a8c0@freqonedev>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 23 May 2008 01:16:24 +0200
References: <01e501c8bc60$e20638c0$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] bluez hcid v3.31 main.conf
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

> On startup, hcid attempts to load_config(CONFIGDIR "main.conf").   
> However, main.conf is missing.  This may have been a recent change  
> in that in hcid.h, HCID_CONFIG_FILE refers to CONFIGDIR "hcid.conf".
>
> When I attempt to substitute HCID_CONFIG_FILE to load_config,  
> load_config chokes on what is in that file.
>
> So, what is/should be contained in main.conf?  Is the correct, or  
> what should it be?  (In general, using a "magic filename" like  
> "main.conf" is not a great practice, and perhaps makes the code base  
> harder to maintain, especially when a #define with a similar purpose  
> already exists in the headers...)

the main.conf contains settings for plugin loading. The file name is  
not set in stone yet. Simply ignore that error :)

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
