Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111118112748.GA5971@x220>
References: <1321551160-8903-1-git-send-email-anderson.lizardo@openbossa.org>
	<20111118112748.GA5971@x220>
Date: Fri, 18 Nov 2011 08:15:15 -0400
Message-ID: <CAJdJm_NH8eQT62CxFKMR1+jxN_B9w81ZCTZrjTJQhHuM2A1zwg@mail.gmail.com>
Subject: Re: [PATCH RFC BlueZ] serial: Fix bogus errno usage
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Nov 18, 2011 at 7:27 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> bt_io_connect is not supposed to touch errno, so please don't send
> patches for that. If you want to get the exact error you pass a GError
> pointer, however even without that it's valid to check at least for a
> NULL return. A simple fix if you don't want to add GError to this port.c
> function is to return e.g. -EIO in case bt_io_connect returns NULL.

I just sent another patch that uses GError if it is set. I hope this
way it works just like the bt_io_connect() call in get_record_cb(), on
the same file.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
