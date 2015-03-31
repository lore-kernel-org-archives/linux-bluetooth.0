Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <004101d06b73$9289a650$b79cf2f0$@samsung.com>
References: <1427692567-631-1-git-send-email-bharat.panda@samsung.com>
	<004101d06b73$9289a650$b79cf2f0$@samsung.com>
Date: Tue, 31 Mar 2015 16:26:47 +0300
Message-ID: <CABBYNZ+wrVLJen3F1Wxx==syH325RwgUL9OcGc6ygtiwhceDkw@mail.gmail.com>
Subject: Re: [PATCH v4] monitor: Add AVDTP support to btmon
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Tue, Mar 31, 2015 at 8:28 AM, Bharat Bhusan Panda
<bharat.panda@samsung.com> wrote:
> ping

Looks like it would be a problem for multiple devices connected since
at assign_scid we don't have the information about the device just the
psm? Did you try that?


-- 
Luiz Augusto von Dentz
