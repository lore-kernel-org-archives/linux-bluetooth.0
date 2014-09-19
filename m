Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <12273172.GZIjs3WGW2@leonov>
References: <1410958395-7174-1-git-send-email-chao.jie.gu@intel.com>
	<12273172.GZIjs3WGW2@leonov>
Date: Fri, 19 Sep 2014 08:27:38 -0700
Message-ID: <CAHrH25R7gynVRb=EUEX_WjixF=cCfPGLqX6H6Dkh9Q-_BRT5Cw@mail.gmail.com>
Subject: Re: [PATCH] Add signed write command
From: Arman Uguray <armansito@chromium.org>
To: Gu Chaojie <chao.jie.gu@intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,

> Add bt_att_set_csrk for btgatt-client tool. However this patch hook into
> shared/mgmt, so btgatt-client now should be running by the root user.

As Szymon said, please split this patch into two: one for gatt-client
and one for the tool. Please use a proper commit message title for
each of them, prefixed with "shared/gatt-client:" and
"tools/btgatt_client:" respectively, with descriptive commit messages
for each patch.

It's also helpful if you add the -v flag when running git format-patch
to assign a version number to each iteration of the patch set. Makes
the reviews easier to keep track of. There are many examples of this
in the mailing list that you can refer to.

Thanks,
Arman
