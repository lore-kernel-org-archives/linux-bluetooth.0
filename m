Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332422680-20162-1-git-send-email-chen.ganir@ti.com>
References: <1332422680-20162-1-git-send-email-chen.ganir@ti.com>
Date: Thu, 22 Mar 2012 09:37:09 -0400
Message-ID: <CAJdJm_MG39-DDvuEpr89u-Ew+K9hFxnZUt5959a2aqYOkph9xA@mail.gmail.com>
Subject: Re: [PATCH 0/2] GATT/ATT Cleanup
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Mar 22, 2012 at 9:24 AM,  <chen.ganir@ti.com> wrote:
> From: Chen Ganir <chen.ganir@ti.com>
>
> Move gatt related primary and characteristic definitions
> from the att.h to gatt.h (ATT does not define services and)
> characteristics - those are GATT terms.
>
> Chen Ganir (2):
>  GATT: Rename service and char structs
>  GATT: replace start/end with att_range
>
>  attrib/att.h         |   13 -------------
>  attrib/client.c      |   22 +++++++++++-----------
>  attrib/gatt.c        |   12 ++++++------
>  attrib/gatt.h        |   12 ++++++++++++
>  attrib/gatttool.c    |    6 +++---
>  attrib/interactive.c |    6 +++---
>  src/adapter.c        |   11 ++++++-----
>  src/device.c         |   14 +++++++-------
>  8 files changed, 48 insertions(+), 48 deletions(-)

Patches look good to me.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
