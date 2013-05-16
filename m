Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH BlueZ 1/2] test: Remove commented out code from simple-agent
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1368710695-22623-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Thu, 16 May 2013 15:45:46 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <318C0863-4CB8-4DC6-B577-13F7D33ADBF6@holtmann.org>
References: <1368710695-22623-1-git-send-email-anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> ---
> test/simple-agent |    3 ---
> 1 file changed, 3 deletions(-)
> 
> diff --git a/test/simple-agent b/test/simple-agent
> index 854e1af..64b2ca8 100755
> --- a/test/simple-agent
> +++ b/test/simple-agent
> @@ -176,6 +176,3 @@ if __name__ == '__main__':
> 		manager.RequestDefaultAgent(path)
> 
> 	mainloop.run()
> -
> -	#adapter.UnregisterAgent(path)
> -	#print("Agent unregistered")

I would prefer if we remove the whole script. Does it provide anything that bluetoothctl is not providing?

Regards

Marcel


