Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Dec 2012 11:29:57 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] test: Fix syntax in bluezutils.py
Message-ID: <20121206142957.GA23489@samus>
References: <1354797576-11286-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1354797576-11286-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 13:39 Thu 06 Dec, Frédéric Danis wrote:
> Traceback (most recent call last):
>   File "./simple-agent", line 12, in <module>
>     import bluezutils
>   File "/home/fdanis/src/bluez/test/bluezutils.py", line 22
>     if not pattern or pattern == adapter["Address"] or
>                                                      ^
> SyntaxError: invalid syntax
> ---
>  test/bluezutils.py |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/test/bluezutils.py b/test/bluezutils.py
> index d0c4773..de08cbd 100644
> --- a/test/bluezutils.py
> +++ b/test/bluezutils.py
> @@ -19,8 +19,8 @@ def find_adapter_in_objects(objects, pattern=None):
>  		adapter = ifaces.get(ADAPTER_INTERFACE)
>  		if adapter is None:
>  			continue
> -		if not pattern or pattern == adapter["Address"] or
> -							path.endswith(pattern)):
> +		if not pattern or pattern == adapter["Address"] or \
> +							path.endswith(pattern):

Ack.


Cheers,
-- 
Vinicius
