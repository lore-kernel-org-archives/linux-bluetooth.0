Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <493064646.889181434018193379.JavaMail.weblogic@epmlwas05b>
References: <493064646.889181434018193379.JavaMail.weblogic@epmlwas05b>
Date: Thu, 11 Jun 2015 16:40:34 +0300
Message-ID: <CABBYNZKBx8foA402TU8Q3xXOHwR2myXeuZsDjRWQ0oExecxS4w@mail.gmail.com>
Subject: Re: Re: Re: Fwd: Fwd: [PATCH 1/1] shared/gatt-client: Fix the "Find
 Information req" error
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: nagaraj.dr@samsung.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nagaraj,

On Thu, Jun 11, 2015 at 1:23 PM, Nagaraj D R <nagaraj.dr@samsung.com> wrote:
> ++correction
> Descriptors are searched between Characteristic value declaration and characteristic definition end handle

No Top posting on this mailing list please.

> ------- Original Message -------
> Sender : Nagaraj D R<nagaraj.dr@samsung.com> Lead Engineer/SRI-Bangalore-System & Connectivity/Samsung Electronics
> Date : Jun 11, 2015 15:46 (GMT+05:30)
> Title : Re: Re: Fwd: Fwd: [PATCH 1/1] shared/gatt-client: Fix the "Find Information req" error
>
> Hello Luiz,
> The problem that I was trying to address is for the characteristic attribute at 0Xfffe and characteristic value declaration at oxffff.
> This is a valid scenario. Characteristic need to have a characteristic value declaration but need not have characteristic descriptors.
>
> Since present design search the descriptors b/w the characteristic value declaration and service end handle,
> if service end handle and characteristic value declaration end handle are same (i.e 0xffff in a particular case)
> then descriptor search handle will be initialized to 0X000 (i.e by incrementing characteristic value handle (0xffff) )
> 0x0000 handle is reserved handle + intention of searching descriptor will not be achieved.

Sound like a different problem than I thought, anyway it is valid so
could you please add this explanation to the patch description and
perhaps a comment to the code so we have it crystal clear why it is
necessary.



-- 
Luiz Augusto von Dentz
