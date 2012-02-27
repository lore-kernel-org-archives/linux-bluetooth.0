Return-Path: <cyrus@holtmann.org>
Message-ID: <1330363233.3392.50.camel@aeonflux>
Subject: Re: [PATCH] hciemu: Always initialize status in hci_host_control
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Mon, 27 Feb 2012 09:20:33 -0800
In-Reply-To: <1330344231-22823-1-git-send-email-szymon.janc@tieto.com>
References: <1330344231-22823-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Assign 0x00 to status on intialization instead of assigning it in each
> switch case. This helps to avoid errors when one forget to proper
> intialize status in new case.
> 
> This fix following compilation error:
> 
>   CC     test/hciemu.o
> cc1: warnings being treated as errors
> test/hciemu.c: In function ‘hci_host_control’:
> test/hciemu.c:786: error: ‘status’ may be used uninitialized in this function
> make[1]: *** [test/hciemu.o] Error 1

actually gcc warns here rightfully, but the fix is actually a different
one:

@@ -783,7 +783,7 @@ static void hci_host_control(uint16_t ocf, int plen, uint8_t
                break;
 
        default:
-               command_status(ogf, ocf, status);
+               command_status(ogf, ocf, 0x01);
                break;
        }

Pushed that one upstream.

I am always suspicious if the fix to a compiler warning like this is
just to initialize the variable. We prefer not to do that since then it
starts hiding real bugs. This is a good example.

Regards

Marcel


