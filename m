Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MG39-DDvuEpr89u-Ew+K9hFxnZUt5959a2aqYOkph9xA@mail.gmail.com>
References: <1332422680-20162-1-git-send-email-chen.ganir@ti.com>
	<CAJdJm_MG39-DDvuEpr89u-Ew+K9hFxnZUt5959a2aqYOkph9xA@mail.gmail.com>
Date: Thu, 22 Mar 2012 11:10:22 -0400
Message-ID: <CAJdJm_NUb8VJwVT-Jgcm=GNVaRW00_WMWTVTEw1ozZwoaCkw6A@mail.gmail.com>
Subject: Re: [PATCH 0/2] GATT/ATT Cleanup
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Mar 22, 2012 at 9:37 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Chen,
>
> On Thu, Mar 22, 2012 at 9:24 AM,  <chen.ganir@ti.com> wrote:
>> From: Chen Ganir <chen.ganir@ti.com>
>>
>> Move gatt related primary and characteristic definitions
>> from the att.h to gatt.h (ATT does not define services and)
>> characteristics - those are GATT terms.
>>
>> Chen Ganir (2):
>>  GATT: Rename service and char structs
>>  GATT: replace start/end with att_range
>>
>>  attrib/att.h         |   13 -------------
>>  attrib/client.c      |   22 +++++++++++-----------
>>  attrib/gatt.c        |   12 ++++++------
>>  attrib/gatt.h        |   12 ++++++++++++
>>  attrib/gatttool.c    |    6 +++---
>>  attrib/interactive.c |    6 +++---
>>  src/adapter.c        |   11 ++++++-----
>>  src/device.c         |   14 +++++++-------
>>  8 files changed, 48 insertions(+), 48 deletions(-)
>
> Patches look good to me.

Your patches do not compile with bootstrap-configure:

In file included from proximity/manager.c:36:0:
proximity/monitor.h:33:41: error: ‘struct att_primary’ declared inside
parameter list [-Werror]
proximity/manager.c: In function ‘primary_uuid_cmp’:
proximity/manager.c:57:23: error: dereferencing pointer to incomplete type
proximity/manager.c: In function ‘attio_device_probe’:
proximity/manager.c:78:8: error: passing argument 3 of
‘monitor_register’ from incompatible pointer type [-Werror]
proximity/monitor.h:31:5: note: expected ‘struct att_primary *’ but
argument is of type ‘struct att_primary *’
proximity/manager.c:78:8: error: passing argument 4 of
‘monitor_register’ from incompatible pointer type [-Werror]
proximity/monitor.h:31:5: note: expected ‘struct att_primary *’ but
argument is of type ‘struct att_primary *’
proximity/manager.c:78:8: error: passing argument 5 of
‘monitor_register’ from incompatible pointer type [-Werror]
proximity/monitor.h:31:5: note: expected ‘struct att_primary *’ but
argument is of type ‘struct att_primary *’
proximity/manager.c: In function ‘primary_uuid_cmp’:
proximity/manager.c:58:1: error: control reaches end of non-void
function [-Werror=return-type]
cc1: all warnings being treated as errors


Please fix this and send a new version. Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
