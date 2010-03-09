Return-Path: <cyrus@holtmann.org>
Message-ID: <4B95F67A.9090305@nokia.com>
Date: Tue, 09 Mar 2010 09:19:22 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: "Tervo Ville (Nokia-D/Helsinki)" <Ville.Tervo@nokia.com>
CC: Nick Pelly <npelly@google.com>, Dave Young <hidave.darkstar@gmail.com>,
        Bluettooth Linux <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Kernel panic in rfcomm_run - unbalanced refcount on 	rfcomm_session
References: <35c90d961002172104q3af1ca8p850004f8b93e8af7@mail.gmail.com> 	<a8e1da1002200017t6e856c7cu1300ac5b3b3a43b@mail.gmail.com> <35c90d961002211300s25507542y9b73724881be5540@mail.gmail.com> <4B87A10C.4070100@nokia.com>
In-Reply-To: <4B87A10C.4070100@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Tervo Ville (Nokia-D/Helsinki) wrote:
> 
> l2cap socket status might change while rfcomm is processing frames. And 
> that makes rfcomm_process_rx to do double rfcomm_session_put() for 
> incoming session reference. We cannot use sk_state.
> 
> Could you try with this patch if it helps to your problems also? My OPP 
> problems went away with this patch.
> 
> I moved rfcomm_session_put() for incoming session to 
> rfcomm_session_close in order to get more clear _hold()/_put() pairs.
> 
> 

Any comments about the patch in previous mail?

-- 
Ville
