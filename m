Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <551C51E2.7060806@message-id.googlemail.com>
References: <551BD9BD.9040501@message-id.googlemail.com>
	<CABBYNZ+EzzcX2uMMrSQvrPhMqnruDxLf5d-vfqHNcZJOD=BCuA@mail.gmail.com>
	<551C51E2.7060806@message-id.googlemail.com>
Date: Thu, 2 Apr 2015 11:14:10 +0300
Message-ID: <CABBYNZKG1fa0d25otWOQqV6fvS=Wb2DE29vDOP0v+RN60fVOpQ@mail.gmail.com>
Subject: Re: unit/test-gatt broken again (as always :-)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

On Wed, Apr 1, 2015 at 11:15 PM, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
> Hi Luiz,
>
> Am 01.04.2015 um 14:08 schrieb Luiz Augusto von Dentz:
>
>> This is actually a fault in our code that the test uncovered which is
>> good but we failed to see it happening, I actually have some plans to
>
> Ok. Then it's good that the openSUSE Buildservice setup has these
> parameters set as default for building :-)
>
>> have a check-valgrind target to catch this type of problems or maybe
>> there is a way to add MALLOC_CHECK_=3 MALLOC_PERTURB_=69 directly.
>
> I can help with that, see attached patch (sorry for the attachment, but
> making thunderbird behave well is out of scope for now :-)

Ive applied this along with the patches to fix the problem, note that
Ive edited you description since we don't use Signed-off-by in
userspace. Thanks a lot for the contribution.


-- 
Luiz Augusto von Dentz
