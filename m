Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <51709E57.7020402@lwfinger.net>
Date: Thu, 18 Apr 2013 20:31:03 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>, linville@tuxdriver.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, champion_chen@realsil.com.cn
Subject: Re: [RFC/RFT PATCH 2/2] rtk_btusb: A new driver for the Bluetooth
 portion of the Realtek RTL8723AE chip
References: <1365469068-4548-1-git-send-email-Larry.Finger@lwfinger.net> <1365469068-4548-3-git-send-email-Larry.Finger@lwfinger.net> <20130418222221.GA15279@joana>
In-Reply-To: <20130418222221.GA15279@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/18/2013 05:22 PM, Gustavo Padovan wrote:
>
> We recently added a setup callback to btusb to run device specific
> initialization, take a look in bluetooth-next to check how that can help you
> avoid duplicate a lot of code.

Thanks for the tip. I knew something was in the planning stage.

Is there any documentation on using the new facility?

Larry
