Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349794286.27233.95.camel@aeonflux>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
 <1349784722-14578-3-git-send-email-szymon.janc@tieto.com> <1349794286.27233.95.camel@aeonflux>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 9 Oct 2012 12:49:09 -0300
Message-ID: <CAMOw1v51MT6AsyCB5X7GVRzbdDsXFJL=Gr5EO9ctJBT=vsBPHA@mail.gmail.com>
Subject: Re: [PATCH 2/9] Pass confirm name as gboolean value
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 9, 2012 at 11:51 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Szymon,
>
>> confirm_name is a boolean value and can be pass as such instead of
>> uint8_t.
>
> actually long term I want to move to bool usage. So maybe this is a good
> start to get this going.

agreed... on new code that I'm adding I'm using bool.

Btw, could we already use bool in gdbus/ ?


Lucas De Marchi
