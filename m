Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4B95F67A.9090305@nokia.com>
References: <35c90d961002172104q3af1ca8p850004f8b93e8af7@mail.gmail.com>
	<a8e1da1002200017t6e856c7cu1300ac5b3b3a43b@mail.gmail.com>
	<35c90d961002211300s25507542y9b73724881be5540@mail.gmail.com>
	<4B87A10C.4070100@nokia.com> <4B95F67A.9090305@nokia.com>
From: Nick Pelly <npelly@google.com>
Date: Mon, 8 Mar 2010 23:31:58 -0800
Message-ID: <35c90d961003082331p6798006do17d6178ae2840591@mail.gmail.com>
Subject: Re: Kernel panic in rfcomm_run - unbalanced refcount on
	rfcomm_session
To: Ville Tervo <ville.tervo@nokia.com>
Cc: Dave Young <hidave.darkstar@gmail.com>,
	Bluettooth Linux <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 8, 2010 at 11:19 PM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Tervo Ville (Nokia-D/Helsinki) wrote:
>>
>> l2cap socket status might change while rfcomm is processing frames. And
>> that makes rfcomm_process_rx to do double rfcomm_session_put() for incoming
>> session reference. We cannot use sk_state.
>>
>> Could you try with this patch if it helps to your problems also? My OPP
>> problems went away with this patch.
>>
>> I moved rfcomm_session_put() for incoming session to rfcomm_session_close
>> in order to get more clear _hold()/_put() pairs.
>>
>>
>
> Any comments about the patch in previous mail?

Your patch looks sane to me, although I know enough of the Bluez
rfcomm state machine to know that I don't know it that well :)

Nick
