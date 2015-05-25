Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BD5E516FF3711A41B93DC005170007BB010E5D9DFDFC@EMBSVR01.ember.local>
References: <BD5E516FF3711A41B93DC005170007BB010E5D9DFBFD@EMBSVR01.ember.local>
	<000701d096bf$1c0194d0$5404be70$@samsung.com>
	<BD5E516FF3711A41B93DC005170007BB010E5D9DFDFC@EMBSVR01.ember.local>
Date: Mon, 25 May 2015 11:31:32 +0300
Message-ID: <CABBYNZK1yHMwVF7Fp3Ba+6xf4W=j7vqWt5AM-hRkmnXqcDwLbA@mail.gmail.com>
Subject: Re: Issue Write Not Permitted Error Response not working
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ankur Patel <ankur@embertec.com>
Cc: Gowtham Anandha Babu <gowtham.ab@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankur,

On Mon, May 25, 2015 at 11:17 AM, Ankur Patel <ankur@embertec.com> wrote:
> Thank you Gowtham Anandha Babu for brief & useful explanation. I understand your concern and my mistake. I did the same and now the Testcase is Passed. As you have mentioned, I am itself using tools/btgatt-server.c application and modifying it to pass the PTS/GATT testcases.
>
> Once I am done, I would like to share modified btgatt-server.c on forum so that anyone wants to pass PTS/GATT testcases, it will be useful.

That would be great, you can also document the PIC/PIXIT and commands
necessary like we did for android, I guess this documents can go under
doc.


-- 
Luiz Augusto von Dentz
