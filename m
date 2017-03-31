Return-Path: <luiz.von.dentz@intel.com>
MIME-Version: 1.0
In-Reply-To: <20170331113218.GA28779@annapurna>
References: <1490958237-9299-1-git-send-email-bergo.torino@gmail.com>
 <1490959289.13868.12.camel@hadess.net> <20170331113218.GA28779@annapurna>
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date: Fri, 31 Mar 2017 17:00:21 +0300
Message-ID: <CACumGOK1ZvY87+Y-XKLRVPN_JGGvpJMcaOHQ0tCWdXyGh4Nb1A@mail.gmail.com>
Subject: Re: [PATCH] core: replace sizeof(filename) with PATH_MAX
To: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
Cc: Bastien Nocera <hadess@hadess.net>, Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Konrad,

On Fri, Mar 31, 2017 at 2:32 PM, Konrad Zapalowicz
<konrad.zapalowicz@canonical.com> wrote:
> On 03/31, Bastien Nocera wrote:
>> On Fri, 2017-03-31 at 13:03 +0200, Konrad Zapalowicz wrote:
>> > From: Konrad Zapa=C5=82owicz <konrad.zapalowicz@canonical.com>
>> >
>> > This commit replaces sizeof(filename) with PATH_MAX to match the
>> > common
>> > scheme which is used in other places.
>>
>> I wonder why g_strdup_printf() isn't used instead. Would allow ignoring
>> PATH_MAX.
>
> I guess it is because it is easier. With g_strdup_printf() one would
> have to take care about freeing memory. This is not a case with having
> filename as an atomatic variable.

Patch looks fine, but we don't use Signed-off-by in userspace tree.
