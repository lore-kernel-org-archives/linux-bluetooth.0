Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111118123221.GA29001@fusion.localdomain>
References: <1321618307-11456-1-git-send-email-anderson.lizardo@openbossa.org>
	<20111118123221.GA29001@fusion.localdomain>
Date: Fri, 18 Nov 2011 09:39:02 -0400
Message-ID: <CAJdJm_NCdp4p2GB-QoY-BMdFb7d8wZFxEO0=vdKWDY1TKs1Dew@mail.gmail.com>
Subject: Re: [PATCH BlueZ] serial: Fix error handling in connect_port()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Nov 18, 2011 at 8:32 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> That's not quite how GError based APIs are supposed to be used and
> implemented. Basically APIs that can report errors through GError make a
> guarantee that if their return value indicates error then the GError
> will also be set (if such a pointer was passed), so it's redundant to
> check both for err < 0 and err != NULL. Furthermore, I wouldn't go
> mixing POSIX errors and GError into the same API, so if you add GError
> support make the function return a gboolean instead of an int (and then
> either pass a GError and check for it when the function returns (but not
> the return value) or don't pass a GError and check for a FALSE return
> value.

Besides the bt_io_connnect() call, connect_port() has calls to other
functions which do not set GError on failure, but instead return a
negative POSIX error. For these, we would need to use g_set_error() to
always have a GError. I think that is too much code just for a single
static function, given that the "serial" plugin is not using GError
for its own errors.

So I will stick with your original suggestion and simply return -EIO
if bt_io_connect() returns NULL (which will fix the original bug).
This can be improved later by changing serial code to better handle
GError for its own errors.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
