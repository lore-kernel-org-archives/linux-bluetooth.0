Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380715758-10334-9-git-send-email-dh79.pyun@samsung.com>
References: <1380715758-10334-1-git-send-email-dh79.pyun@samsung.com>
	<1380715758-10334-9-git-send-email-dh79.pyun@samsung.com>
Date: Wed, 2 Oct 2013 08:20:32 -0400
Message-ID: <CAJdJm_NYpd7J5wsHGEskzL1q_o5sFsf-RX20OVyja-Pn_c87xQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] Bluetooth: Add Slave Page Response Timeout Event
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Dohyun Pyun <re20sfree@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dohyun,

On Wed, Oct 2, 2013 at 8:09 AM, Dohyun Pyun <re20sfree@gmail.com> wrote:
> From: DoHyun Pyun <dh79.pyun@samsung.com>
>
> The Slave Page Response Timeout event indicates to the Host that a
> slave page response timeout has occurred in the BR/EDR Controller.
>
> The Core Spec Addendum 4 adds this command in part B Connectionless
> Slave Broadcast.
>
> Bluetooth Core Specification Addendum 4 - Page 110
>
> "7.7.67 Synchronization Train Complete Event [New Section]

The section for this event is actually:

"7.7.72 Slave Page Response Timeout Event [New Section]"

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
