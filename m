Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1338205401-32054-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
References: <1338205401-32054-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
Date: Mon, 28 May 2012 16:44:05 +0300
Message-ID: <CABBYNZJCCTefo4E6KdUKcuGUsttQX6BDBCHWJFWFgrUxL8D8Lg@mail.gmail.com>
Subject: Re: [PATCH 2/2] audio: Keep AVDTP POSIX error codes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Kanak Gupta <kanak.gupta@stericsson.com>,
	Anurag Gupta <anurag.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, May 28, 2012 at 2:43 PM, Par-Gunnar Hjalmdahl
<par-gunnar.hjalmdahl@stericsson.com> wrote:
> This patch adds functionality to prevent constant use of the EIO POSIX
> error code for AVDTP responses. The POSIX error codes generated
> by AVDTP are now kept.

Since we are going to remove the audio IPC this would be useless.

-- 
Luiz Augusto von Dentz
