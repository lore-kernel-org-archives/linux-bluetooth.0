Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dohyun Pyun <re20sfree@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>
Subject: Re: [PATCH Bluez] tools/l2test: Fix potention double close
In-Reply-To: <1436859557-16153-1-git-send-email-dh79.pyun@samsung.com>
References: <1436859557-16153-1-git-send-email-dh79.pyun@samsung.com>
Date: Thu, 23 Jul 2015 18:23:32 -0300
Message-ID: <87a8um6017.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Dohyun Pyun <re20sfree@gmail.com> writes:

> From: DoHyun Pyun <dh79.pyun@samsung.com>
>
> If the test gets an error after close the socket, the socket sk
> will be closed again. This patch prevents the double close case.

minor: typo on the subject: s/potention/potencial/.

The code looks good.


Cheers,
--
Vinicius
