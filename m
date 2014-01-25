Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Fri, 24 Jan 2014 22:00:26 -0400
Message-ID: <CAJdJm_NYECBW1hH+PmYtQqoBL-_279_hjfgqWD8i85bi9nHJiw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] Basic [sg]etsockopt() testing in l2cap-tester
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jan 24, 2014 at 9:54 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> PS: For some reason, the following tests are failing on my system, even using
> an older kernel:
>
> L2CAP LE Client - Success
> L2CAP LE Client SMP - Success
> L2CAP LE Client - Command Reject
> L2CAP LE Client - Invalid PSM
> L2CAP LE Server - Success
>
> connect() is returning EINVAL.  Any ideas for why this may be happening?

Actually I know why they fail: the tests try to use a PSM (and not
CID) on a single mode LE adapter. I just don't understand why this is
expected to work.

Best Regards,
-- 
Anderson Lizardo
INdT - Manaus - Brazil
