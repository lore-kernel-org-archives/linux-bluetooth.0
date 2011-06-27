Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Health Thermometer Profile API
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Elvis Pfutzenreuter <epx@signove.com>
In-Reply-To: <BANLkTikH10YNTycwJ5nUxL7fjrhaLn_PAQ@mail.gmail.com>
Date: Mon, 27 Jun 2011 12:09:31 -0300
Cc: mike tsai <mikeyhtsai@gmail.com>, linux-bluetooth@vger.kernel.org
Message-Id: <E5434DF4-3863-4DA6-8FF8-AA74ED68A0A0@signove.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com> <C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com> <BANLkTikNQac7UsMgKdnoVR7kVQSV6tVn6g@mail.gmail.com> <A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com> <BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com> <544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com> <BANLkTim60FHUp0B+2LkrsEG9vW4awFvvwQ@mail.gmail.com> <75C285AD-9C2B-4F57-A998-D1346A68AEEE@signove.com> <BANLkTi=YHkhEiffbRuXWyqKa_Xw31W6JXw@mail.gmail.com> <092E3C75-499E-4E78-A167-F2DB57A0051E@signove.com> <BANLkTikH10YNTycwJ5nUxL7fjrhaLn_PAQ@mail.gmail.com>
To: Santiago Carot <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> (cut)
>> 
>> Thing is, you need to show each client app process a different 'view' of
>> those D-Bus properties. It is feasible, but it is a new trick, not
>> employed in other APIs.
> 
> I think that it may work for Final and Intermediate but not for the
> Interval property that is common for all agents. Besides, this
> characteristic can be readed/writed through the D-Bus attribute API
> too as Anderson said.

Agreed. Interval is unsolvable; there is only one per device.

