Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201102231437.10401.szymon.janc@tieto.com>
References: <1298456785-1572-1-git-send-email-szymon.janc@tieto.com>
	<1298456785-1572-2-git-send-email-szymon.janc@tieto.com>
	<AANLkTin=5B6E26nzSkGad0W7FfTc+3S0_7F7ErsBLbbp@mail.gmail.com>
	<201102231437.10401.szymon.janc@tieto.com>
Date: Wed, 23 Feb 2011 10:49:37 -0300
Message-ID: <AANLkTinDrFOS7RdXo8G07SWZuNB_bKFPUUtqp7b7yY5Z@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: Move index to common header in management interface
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Feb 23, 2011 at 10:37 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> In general, I think all commands which used to have controller index
>> as parameters (both cp and rp), would need to be modified because
>> index is already part of the header.
>
> Actually all commands were modified, just missed to null parameters.

Just to make it clear, there are other occurrences which should be
changed to null parameters as well:

set_dev_class()
set_service_cache()
set_io_capability()

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
