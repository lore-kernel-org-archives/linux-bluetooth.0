Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100924151552.GG4061@null>
References: <AANLkTi=QaWXz2BEsUJPpXQjvGuGm8CtctJ_q-7WNC=VH@mail.gmail.com>
	<AANLkTikS2-eKiEP2ngqz6rW5JB-+eudtffw9QHykhbqq@mail.gmail.com>
	<AANLkTikAHAKe2WDMuAKEvCXh6jxGXFYYhfWPJkCGXUSp@mail.gmail.com>
	<AANLkTi=9o+9KFNTGcYBZd0z+kYVwBj-Z1LxwdPsjTSfw@mail.gmail.com>
	<AANLkTikE91qpOgsio9WRaunaAyX3JDWXX0Oz4DvUvspU@mail.gmail.com>
	<20100924081642.GA30391@null>
	<AANLkTi=8QV8n1c2cghbbyNv1pZKbHPPRzbv0zVZ_5Vk8@mail.gmail.com>
	<20100924151552.GG4061@null>
Date: Fri, 24 Sep 2010 18:11:32 -0700
Message-ID: <AANLkTik_cwho9JNBPFhCDx0EGFcLN2+VTG8LT-D_Hw_3@mail.gmail.com>
Subject: Re: Bluez simple-agent vs agent
From: Viswanathan Sankararam <developervishwa@gmail.com>
To: Ville Tervo <ville.tervo@nokia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Ville for letting me know about this. Is there a possibility to
back port? Can I just blindly copy the net/bluetooth drivers to a
linux-2.6.23 kernel and compile?

On Fri, Sep 24, 2010 at 8:15 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Hi,
>
> On Fri, Sep 24, 2010 at 04:09:08PM +0200, ext Viswanathan Sankararam wrote:
>> Im using linux2.6.23... by todays standard, this is old I guess but
>> could it be the cause?
>
> Yes that ioctl was introduced in 2.6.27.
>
> And please don't remove mailing list from discussion.
>
> --
> Ville
>
