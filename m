Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369141604-1129-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
	<1369141604-1129-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Tue, 28 May 2013 09:25:18 -0400
Message-ID: <CAJdJm_NPgMvsOpRpzXbXcchy-aUBNqCKs894mnr_svbZNScQJw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/2] plugins: Use open()/read() instead of
 fopen()/fread() on autopair
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 21, 2013 at 9:06 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> open()/read() is more common on BlueZ code. Incidentally, get rid of
> this compilation error (using gcc 4.6.3):
>
> plugins/autopair.c: In function ‘autopair_init’:
> plugins/autopair.c:154:8: error: ignoring return value of ‘fread’,
> declared with attribute warn_unused_result [-Werror=unused-result]
> ---
>  plugins/autopair.c |   22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> v3:
>
> * Fix buggy logic
> * The obvious code path is tested by just starting bluetoothd, which will call
>   autopair_init()
> * Maybe overkill, but I used this mockup code to test other unreachable code
>   paths: http://ix.io/5JC
> * I agree with Marcel that we should just fail if /dev/urandom is not readable.
>   Otherwise, we are introducing code that will 99% of the time not be run
>   (unless someone confirms that we have systems with unusable /dev/urandom).

Ping. There were no further comments on the idea of removing the
"time(NULL)" fallback suggested by Marcel.

Should I proceed with dropping the time(NULL) fallback or may this
patch be applied as is?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
