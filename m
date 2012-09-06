Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120822201930.GC14913@tuxdriver.com>
References: <20120822201930.GC14913@tuxdriver.com>
Date: Thu, 6 Sep 2012 10:25:33 -0400
Message-ID: <CAJdJm_Px_see=f1W09BeV+F7qP-=U6CPkk_NUU5KCtjvxLuYqQ@mail.gmail.com>
Subject: Re: Agenda for Linux Wireless (802.11/Bluetooth/NFC) Mini-Summit 2012 (Barcelona!)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	alexander.smirnov@siemens.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-wireless-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Wed, Aug 22, 2012 at 4:19 PM, John W. Linville
<linville@tuxdriver.com> wrote:
> All,
>
> The time for our meeting in Barcelona is drawing near.  I think it
> is time that we start nailing-down the agenda.
>
> We have one room on the first day, and three rooms on the second day.
> I figure that the Bluetooth and 802.11 groups should each get a
> break-out room for their own in-depth discussons on the second day and
> the third room can be used for more general topics and presentations.
>
> With that said, there are still a number of slots available for
> presentations or discussion topics.  This is especially true for the
> 802.11 group...  Please step-up with some suggested topics!

If there are still available slots, we would like to present and
discuss our current proposal for a Bluetooth Broadcaster/Observer API.
These are new GAP Operational Modes for connectionless communication
available since Core spec 4.0 (it is specified for LE channel, but the
plan is to reuse the same API for broadcasting and observing data over
EIR on BR/EDR channel as well).

Title: Bluetooth Broadcaster/Observer API
Speakers: Anderson Lizardo, Jefferson Delfes

The relevant patch series:

http://thread.gmane.org/gmane.linux.bluez.kernel/28228 (kernel space
management API)
http://thread.gmane.org/gmane.linux.bluez.kernel/28798 (userspace API in BlueZ)

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
