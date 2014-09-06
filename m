Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <540B5B03.9070203@lwfinger.net>
Date: Sat, 06 Sep 2014 14:05:39 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Champion Chen <champion_chen@realsil.com.cn>,
 Stable <stable@vger.kernel.org>
Subject: Re: [PATCH] bluetooth: btusb: Fix issue with suspend
References: <1409930194-6318-1-git-send-email-Larry.Finger@lwfinger.net> <6DF81E54-681F-4B18-95C7-F4684FF19786@holtmann.org> <540B4159.9000003@lwfinger.net> <D5B40282-A085-4B47-8F7B-27480CAB6B19@holtmann.org>
In-Reply-To: <D5B40282-A085-4B47-8F7B-27480CAB6B19@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 09/06/2014 12:35 PM, Marcel Holtmann wrote:
> Hi Larry,
>
>
> one other thing. Please let maintainers decide when a patch is useful for stable and when not. Patches need to go upstream first anyway. People spamming stable@vger.kernel.org with patches that are not reviewed yet is pretty much a waste of time.

Sorry. In the wireless tree, the patch author suggests that the patch is 
suitable for stable. If the maintainer disagrees, he strips the Cc to stable. It 
seems that you do it the other way. In either case, I do not think the stable 
patches are picked up by the maintainers of stable versions until the patch hits 
mainline.

Larry
