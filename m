Return-Path: <cyrus@holtmann.org>
Date: Wed, 04 Jan 2012 12:55:23 -0500
From: Denys Dmytriyenko <denis@denix.org>
To: linux-bluetooth@vger.kernel.org
Subject: BlueZ old releases have different checksums
Message-id: <20120104175522.GC587@denix.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Sorry if it was covered previously, but my various searches didn't bring any 
relevant results...

On December 22/23 the entire archive of previous BlueZ/obexd/hcidump releases 
re-appeared on kernel.org after missing for long time due to the server 
compromise. Well, it looks like all the tarballs were re-created and 
re-packaged, thus they all have new checksums. Unfortunately, since filenames 
were not changed (i.e. FSF had to re-publish all releases of binutils and they 
added an 'a' suffix to filenames), this breaks Linux distributions that fetch 
and build from sources (like OpenEmbedded and Yocto based distros), since 
checksums don't match. The situation is even worse since many mirrors have old 
copies of the tarballs...

The question I have is whether this is known and was it done on purpose? What 
can be done to fix this situation for users of the old releases, besides 
upgrading to the very latest releases of BlueZ/obexd/hcidump? Thank you for 
your attention.

-- 
Denys
