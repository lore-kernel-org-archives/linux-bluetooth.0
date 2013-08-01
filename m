Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Aug 2013 10:55:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Opencode strndupa in print_string
Message-ID: <20130801075501.GA4068@x220.p-661hnu-f1>
References: <1375260699-7271-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375260699-7271-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Jul 31, 2013, Szymon Janc wrote:
> Strndupa is GNU extension. print_string is simple and opencoding
> strndupa is not a big loss.
> 
> This fix linkage error with bionic library which doesn't provide
> strndupa.
> 
> target Executable: btmon (out/target/product/grouper/obj/EXECUTABLES/
>     btmon_intermediates/LINKED/btmon)
> prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.6/bin/../lib/gcc/
>     arm-linux-androideabi/4.6.x-google/../../../../
>     arm-linux-androideabi/bin/ld: out/target/product/grouper/obj/
>     EXECUTABLES/btmon_intermediates/monitor/sdp.o: in function
>     print_string:external/bluetooth/bluez/monitor/sdp.c:146: error:
>     undefined reference to 'strndupa'
> collect2: ld returned 1 exit status
> make: *** [out/target/product/grouper/obj/EXECUTABLES/
>     btmon_intermediates/LINKED/btmon] Error
> ---
>  monitor/sdp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
