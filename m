Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=k=Dvsm6fySREejtP3sf7Cch3G2KYr4sYpg2Q4@mail.gmail.com>
References: <AANLkTi=k=Dvsm6fySREejtP3sf7Cch3G2KYr4sYpg2Q4@mail.gmail.com>
Date: Sun, 28 Nov 2010 09:22:00 -0700
Message-ID: <AANLkTi=VPn1k=kLdo7QbM4epc88fdcW2XsbLyFeYt9y4@mail.gmail.com>
Subject: Re: wi2wi bluecore4
From: Brad Midgley <bmidgley@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

forgot to mention... just doing the most straightforward hciattach
also won't work

# hciattach -s 115200 ttyS1 csr 921600
CSR build ID 0x0C-0x5C
Device setup complete
root@omap3-multi:~# hciconfig
hci0:   Type: BR/EDR  Bus: UART
        BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:4 acl:0 sco:0 commands:1 errors:0

root@omap3-multi:~# hciconfig hci0 up
Can't init device hci0: Connection timed out (110)
root@omap3-multi:~# hciconfig hci0 revision
Can't read version info for hci0: Network is down (100)

-- 
Brad Midgley
