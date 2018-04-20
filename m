Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 20 Apr 2018 12:00:36 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: linux-bluetooth@vger.kernel.org
Subject: [blueZ] Readline mandatory ?
Message-ID: <20180420120036.040c1b09@windsurf.numericable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Until commit bee3796113196da1b3f56da42fcae4d9bae6695e, the readline
library was an optional dependency of bluez (only needed when
--enable-client was used).

However, following this commit, shell.c is now built as part of
libshared, and readline becomes a mandatory dependency, which is not even
checked by the configure script. This leads to a build failure such as:

src/shared/shell.c:39:31: fatal error: readline/readline.h: No such file or directory
 #include <readline/readline.h>

Is this an intended side effect of commit
bee3796113196da1b3f56da42fcae4d9bae6695e ? If yes, then the configure
script should be adjusted accordingly. If not, how should the code be
fixed to not use readline unconditionally ?

The fact that readline is under GPLv3 might be an issue for some
people, so having it as a mandatory dependency might be problematic.

The problem reported here exists in both the 5.49 release and the
latest master branch as of a085d8c88bd45474d3f9d9a0d3d20ebf7de858f6.

Any hint on how to resolve this issue ?

Thanks,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
