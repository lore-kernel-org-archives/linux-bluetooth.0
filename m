Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix suspend stream on opening if no data
From: Bastien Nocera <hadess@hadess.net>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1286972456-6168-2-git-send-email-dmitriy.paliy@nokia.com>
References: <1286972456-6168-1-git-send-email-dmitriy.paliy@nokia.com>
	 <1286972456-6168-2-git-send-email-dmitriy.paliy@nokia.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 13 Oct 2010 13:24:42 +0100
Message-ID: <1286972682.12284.43.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2010-10-13 at 15:20 +0300, Dmitriy Paliy wrote:
> +               /* Try to write to stream and suspend the stream
> immidiately

Should be immediately (and in the log message as well)

