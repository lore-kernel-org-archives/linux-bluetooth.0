Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG=X57uJqf2kuedzNjJCVvy5RKyWwcM7nSJjgOn24jBOn40Z7g@mail.gmail.com>
References: <CAG=X57uJqf2kuedzNjJCVvy5RKyWwcM7nSJjgOn24jBOn40Z7g@mail.gmail.com>
Date: Wed, 27 Apr 2016 15:08:18 -0700
Message-ID: <CAG=X57u1_b_aajsMd3p5ZSN6=0q7PnRgWa7izWxCpOr1QvSYcQ@mail.gmail.com>
Subject: Re: GATT Client
From: NagaChaitanya Vellanki <nagachaitanya.vellanki@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

More context info here

sudo ./main -d B0:34:95:58:E5:08
Connecting to device... Done
[GATT client]# help
Commands:
        help                    Display help message
        services                Show discovered services
        read-value              Read a characteristic or descriptor value
        read-long-value         Read a long characteristic or desctriptor value
        read-multiple           Read Multiple
        write-value             Write a characteristic or descriptor value
        write-long-value        Write long characteristic or descriptor value
        write-prepare           Write prepare characteristic or descriptor value
        write-execute           Execute already prepared write
        register-notify         Subscribe to not/ind from a characteristic
        unregister-notify       Unregister a not/ind session
        set-security            Set security level on le connection
        get-security            Get security level on le connection
        set-sign-key            Set signing key for signed write command
[GATT client]# services
GATT client not initialized
[GATT client]#

Would like to understand what needs to be done to initialize the GATT Client.

Thank you,
NagaChaitanya Vellanki

On Wed, Apr 27, 2016 at 12:15 PM, NagaChaitanya Vellanki
<nagachaitanya.vellanki@gmail.com> wrote:
> Hi all,
> I am trying to run the btgatt-client.c example in the source
> code(http://git.kernel.org/cgit/bluetooth/bluez.git/tree/tools/btgatt-client.c)
> to connect to the TI sensor tag. But I am getting 'GATT Client not
> initialized'. Please let me know how can i initialize the GATT
> Client?.
>
> Thank you,
> NagaChaitanya Vellanki
