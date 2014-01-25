Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NYECBW1hH+PmYtQqoBL-_279_hjfgqWD8i85bi9nHJiw@mail.gmail.com>
References: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
	<CAJdJm_NYECBW1hH+PmYtQqoBL-_279_hjfgqWD8i85bi9nHJiw@mail.gmail.com>
Date: Fri, 24 Jan 2014 22:50:23 -0400
Message-ID: <CAJdJm_Ns_gNUuwQXOxXXe5pvnrHrwpq=ApD-Ee37Kjx3N=XaZw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] Basic [sg]etsockopt() testing in l2cap-tester
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again,

On Fri, Jan 24, 2014 at 10:00 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Actually I know why they fail: the tests try to use a PSM (and not
> CID) on a single mode LE adapter. I just don't understand why this is
> expected to work.

I now realise that this has to do with LE CoC. Would it be okay to
make l2cap-tester check for
/sys/module/bluetooth/parameters/enable_lecoc at test setup and if it
contains "N", skip the test?

Best Regards,
-- 
Anderson Lizardo
INdT - Manaus - Brazil
