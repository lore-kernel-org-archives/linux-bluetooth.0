Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Dec 2012 22:26:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Subject: Re: [PATCH BlueZ] test: Fix syntax in bluezutils.py
Message-ID: <20121206202657.GA16256@x220>
References: <1354824780-21903-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354824780-21903-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 06, 2012, Vinicius Costa Gomes wrote:
> Traceback (most recent call last):
>   File "./simple-agent", line 12, in <module>
>     import bluezutils
>   File "/home/fdanis/src/bluez/test/bluezutils.py", line 22
>     if not pattern or pattern == adapter["Address"] or
>                                                      ^
> SyntaxError: invalid syntax
> ---
>  test/bluezutils.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
