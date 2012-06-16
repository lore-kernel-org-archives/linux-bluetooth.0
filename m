Return-Path: <cyrus@holtmann.org>
Message-ID: <1339886587.20079.2.camel@sirocco.config>
Subject: Broken bluez master
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 17 Jun 2012 00:43:07 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't think I'm using a too weird development environment, trying to fix
PS3 BD Remote bugs.

Fedora 17 with kernel 3.4.0 and bluez master. Turns out it's unusable
because of this commit:
commit d22d083d6dd681f8d25eb806d4ec91853475ee06
Author: Gustavo Padovan <gustavo@padovan.org>
Date:   Thu Apr 5 16:22:55 2012 -0300

    mgmt: update mgmt control channel id
    
    kernel side has updated its control channel id from 1 to 3.

Do we really need a devel kernel to work on user-space? Reverting this
patch makes it work, I just wish I didn't spend my development time
trying to find what was wrong with my system...

Cheers

