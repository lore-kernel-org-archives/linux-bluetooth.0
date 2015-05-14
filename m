Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25Rxdqucm04R_2dTzAFCqcnJ1nnC++7Es-_z+m=goK_18w@mail.gmail.com>
References: <CAFD1m3FJyojPvf_f-=UTH7P+-_qgvt2iomWP+2oC3YAKxh_Rpg@mail.gmail.com>
 <CAHrH25Rxdqucm04R_2dTzAFCqcnJ1nnC++7Es-_z+m=goK_18w@mail.gmail.com>
From: John Carter <john.carter@taitradio.com>
Date: Thu, 14 May 2015 17:26:37 +1200
Message-ID: <CAFD1m3F+ZaKxXL_=iB6XPM5DTy9oNT+8juMrV57ss-bQqYt=MQ@mail.gmail.com>
Subject: Re: What does "Not enough free handles to register service" in
 bluetoothd logs mean?
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, May 14, 2015 at 2:41 PM, Arman Uguray <armansito@chromium.org> wrote:
> ll plugins that make use of src/attrib-server
> are now defunct,

So, as I read that, that implies the proximity profile is currently defunct?

grep -r attrib-server *
attrib/gatt-service.c:#include "src/attrib-server.h"
Makefile.am:            src/attrib-server.h src/attrib-server.c \
plugins/gatt-example.c:#include "src/attrib-server.h"
profiles/time/server.c:#include "src/attrib-server.h"
profiles/proximity/linkloss.c:#include "src/attrib-server.h"
profiles/proximity/reporter.c:#include "src/attrib-server.h"
profiles/proximity/immalert.c:#include "src/attrib-server.h"
profiles/alert/server.c:#include "src/attrib-server.h"
src/attrib-server.c:#include "attrib-server.h"
src/adapter.c:#include "attrib-server.h"
src/device.c:#include "attrib-server.h"

Is it planned to be revived? Or is there another way of accessing the
same functionality?

Thanks!

-- 
John Carter
Phone : (64)(3) 358 6639
Tait Electronics
PO Box 1645 Christchurch
New Zealand

-- 

------------------------------
This email, including any attachments, is only for the intended recipient. 
It is subject to copyright, is confidential and may be the subject of legal 
or other privilege, none of which is waived or lost by reason of this 
transmission.
If you are not an intended recipient, you may not use, disseminate, 
distribute or reproduce such email, any attachments, or any part thereof. 
If you have received a message in error, please notify the sender 
immediately and erase all copies of the message and any attachments.
Unfortunately, we cannot warrant that the email has not been altered or 
corrupted during transmission nor can we guarantee that any email or any 
attachments are free from computer viruses or other conditions which may 
damage or interfere with recipient data, hardware or software. The 
recipient relies upon its own procedures and assumes all risk of use and of 
opening any attachments.
------------------------------
