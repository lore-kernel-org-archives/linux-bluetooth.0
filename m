Return-Path: <rwaldrop@urbana.css.mot.com>
Date: Thu, 28 Jul 2005 14:10:20 -0500
From: Robert L Waldrop <bob.waldrop@motorola.com>
To: martin.herfurt@trifinite.org, marcel@holtmann.org,
   bluez-users@lists.sourceforge.net
Subject: OPP and execl
Message-ID: <20050728191020.GD7483@urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

Hi Everyone in BlueZ world,

I'm playing around with some OPP fun and was wondering whether anyone
had run into security issues using execl(...) from unistd.h.  I'm 
wondering if it is prone to a shell attack or buffer overrun if I
use it like this...

execl("/my/mycmd","mycmd","arg1","arg2");

Somehow the call forces arg1 (regardless of content, including special
characters like semi-colons) to be the argument of mycmd.  But I'm
curious if maybe there is a combination of characters that aren't 
escaped correctly and someone might be able to invoke a second command
or effect the kernel.  

Also wondering if I'm susceptible to someone passing a large string 
as arg1 if I open that up to the user.

If there are such problems, what is the typical answer to the need for
exec.

Muchas Gracias!

--bob w.

-- 
Robert Waldrop                  Motorola Personal Communications Sector
rwaldrop@urbana.css.mot.com     Urbana-Champaign Design Center
voice  217-384-8719             1800 South Oak Street
                                Champaign IL 61820

[X]  Motorola General Business Information
[ ]  Motorola Internal Use Only
[ ]  Motorola Confidential Proprietary
