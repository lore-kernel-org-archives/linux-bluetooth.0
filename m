Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1527506165-8177-1-git-send-email-krzk@kernel.org>
References: <1527506165-8177-1-git-send-email-krzk@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 May 2018 14:39:06 +0300
Message-ID: <CABBYNZK5wO3=vQaGk_WbDuUYW0hL3x16-aeVkuRQ-9f4QsR4pA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] test: Switch to Python3
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Krzysztof,

On Mon, May 28, 2018 at 2:16 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Python2 will be maintained till end of 2019.  Switch to Python3 by
> replacing iteritems() with items() to fix error when runnig test-nap:
>
>         AttributeError: 'dbus.Dictionary' object has no attribute 'iteritems'
> ---
>  test/bluezutils.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/bluezutils.py b/test/bluezutils.py
> index de08cbdcb712..afbadfecd214 100644
> --- a/test/bluezutils.py
> +++ b/test/bluezutils.py
> @@ -15,7 +15,7 @@ def find_adapter(pattern=None):
>
>  def find_adapter_in_objects(objects, pattern=None):
>         bus = dbus.SystemBus()
> -       for path, ifaces in objects.iteritems():
> +       for path, ifaces in objects.items():
>                 adapter = ifaces.get(ADAPTER_INTERFACE)
>                 if adapter is None:
>                         continue
> --
> 2.7.4

Applied, thanks.

-- 
Luiz Augusto von Dentz
