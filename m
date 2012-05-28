Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.hjalmdahl@stericsson.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Kanak GUPTA <kanak.gupta@stericsson.com>,
	Anurag GUPTA-1 <anurag.gupta@stericsson.com>
Date: Mon, 28 May 2012 16:02:46 +0200
Subject: RE: [PATCH 2/2] audio: Keep AVDTP POSIX error codes
Message-ID: <81C3A93C17462B4BBD7E272753C10579232F445E45@EXDCVYMBSTM005.EQ1STM.local>
References: <1338205401-32054-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
 <CABBYNZJCCTefo4E6KdUKcuGUsttQX6BDBCHWJFWFgrUxL8D8Lg@mail.gmail.com>
In-Reply-To: <CABBYNZJCCTefo4E6KdUKcuGUsttQX6BDBCHWJFWFgrUxL8D8Lg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> 
> Since we are going to remove the audio IPC this would be useless.
> 
> --
> Luiz Augusto von Dentz

Yes, I'm of course aware of the switch to Media API, but since we
found these issues and the files still exist on bluetooth-next, I
thought that we might as well submit the patches.

But I fully understand if you don't want to have any further
changes to these files.

/P-G
