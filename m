Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <504F2CF9.7060900@ti.com>
References: <1347353240-1942-1-git-send-email-chen.ganir@ti.com>
	<CAJdJm_OZZ+SrYdfbpqy+yFmppx9xAs-YMmDtn3PzQbU1JD_pOA@mail.gmail.com>
	<504F2CF9.7060900@ti.com>
Date: Tue, 11 Sep 2012 08:27:25 -0400
Message-ID: <CAJdJm_OMtRy08-55cxrWH-0WM06r0M8JAH8wHw0a8S11k2hO+Q@mail.gmail.com>
Subject: Re: [PATCH v2] gatt: Delay D-Bus reply on char discovery
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Chen Ganir <chen.ganir@ti.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Tue, Sep 11, 2012 at 8:22 AM, Chen Ganir <chen.ganir@ti.com> wrote:
> The plan is to replace characteristic::format, and add CCC, SCC and any
> other descriptor we find in the future to this list. This way we have a
> unified list of descriptors and the data contained in them. This is already
> done in some patches i already have, which rely on this patch. Next patch
> set includes notification/indication implementation to the D-Bus API (Auto
> registration to notification/indication if CCC is found).

Do you have patches ready for adding CCC support on GATT D-Bus API ?
Are you planning to send soon to the list, or could send it as RFC?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
