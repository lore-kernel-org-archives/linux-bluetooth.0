Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <e5fc24930906181903u62c28da2s7f942611661663b4@mail.gmail.com>
References: <e5fc24930906181903u62c28da2s7f942611661663b4@mail.gmail.com>
Date: Fri, 19 Jun 2009 10:39:58 -0300
Message-ID: <2d5a2c100906190639i545e7666k2938966f79be74c3@mail.gmail.com>
Subject: Re: On A2DP frame transmissions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jun <yanjunrockets@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 18, 2009 at 11:03 PM, Jun<yanjunrockets@gmail.com> wrote:
> Hi All,
>
> I'm new to BlueZ and I'd like to dynamically schedule A2DP frame
> transmissions for a project. I did some research on BlueZ and so far I
> feel hcidump and l2cap.c are most related. Due to the large code base,
> could anyone please give me more directions on what to further look
> at?
>

The protocol used by a2dp is avdtp which is currently implemented in
userspace, you can start by looking here:
http://git.kernel.org/?p=bluetooth/bluez.git;a=blob;f=audio/avdtp.c;h=ed84b2178fc953c373669ecef842a7c6e6f9a343;hb=HEAD

I you could disclose what this project is about this would help us
giving you directions.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
