Return-Path: <cyrus@holtmann.org>
Message-ID: <1325706543.6454.64.camel@aeonflux>
Subject: Re: BlueZ old releases have different checksums
From: Marcel Holtmann <marcel@holtmann.org>
To: Denys Dmytriyenko <denis@denix.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 04 Jan 2012 11:49:03 -0800
In-Reply-To: <20120104175522.GC587@denix.org>
References: <20120104175522.GC587@denix.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Denys,

> Sorry if it was covered previously, but my various searches didn't bring any 
> relevant results...
> 
> On December 22/23 the entire archive of previous BlueZ/obexd/hcidump releases 
> re-appeared on kernel.org after missing for long time due to the server 
> compromise. Well, it looks like all the tarballs were re-created and 
> re-packaged, thus they all have new checksums. Unfortunately, since filenames 
> were not changed (i.e. FSF had to re-publish all releases of binutils and they 
> added an 'a' suffix to filenames), this breaks Linux distributions that fetch 
> and build from sources (like OpenEmbedded and Yocto based distros), since 
> checksums don't match. The situation is even worse since many mirrors have old 
> copies of the tarballs...
> 
> The question I have is whether this is known and was it done on purpose? What 
> can be done to fix this situation for users of the old releases, besides 
> upgrading to the very latest releases of BlueZ/obexd/hcidump? Thank you for 
> your attention.

I have no idea what these kernel.org people did with it, but I uploaded
the original tar.gz release. However just taking the 4.0 release, you
are correct, there is a difference.

@@ -1,4 +1,4 @@
-0000000 8b1f 0008 b6f4 4ef3 0302 3cec 7ff1 b6da
+0000000 8b1f 0008 dbf0 4899 0302 3cec 7ff1 b6da
 0000010 fdb3 fe35 342b 96c6 0590 da12 dda4 6592
 0000020 135f 0870 04af 00f8 db59 fdad c6ba f018
 0000030 6c6a b6be 9b49 fdad dfdf 49dd 65b2 4930

I have no idea why they unpacked and re-packed the tar.gz files, but I
can not really do much about it.

Regards

Marcel


