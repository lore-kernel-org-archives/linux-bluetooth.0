Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7B53A3173656CB4190908401FE75F4F85CC0D1CE@exgmbxfz01.sasken.com>
References: <7B53A3173656CB4190908401FE75F4F85CC0D1CE@exgmbxfz01.sasken.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Aug 2017 16:15:54 +0300
Message-ID: <CABBYNZJncfY1tPqVTXbGG0eUtj9C56hh8YbiBLH3T_pyM=zziw@mail.gmail.com>
Subject: Re: Query Regaring usage of RegisterApplication Method using Gio Api
To: Anitha Chandrasekar <anitha.chandrasekar@sasken.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anitha,

On Tue, Aug 8, 2017 at 3:01 PM, Anitha Chandrasekar
<anitha.chandrasekar@sasken.com> wrote:
> Hi ,
>
> We need to call RegisterApplication function from our application for aut=
o-connect of devices. We are registering the GattProfile1 object and callin=
g RegisterApplication method using Gio Api.
>
> But we are getting a "No object Found " error every time. Could you pleas=
e let us know if there is any example code for the same or if you could sug=
gest the API usage from d-feet tool.
> d-feet ->
> I dont see GattProfile1 being listed in d-feet and there is only Register=
Application api, can I know what input params to be given and usage of it.T=
hanks in advance.

You need to implement GattProfile1 in the side of the application and
that should contain ObjectManager object since that is how bluetoothd
is able to list the available objects, you should be able to see the
available interfaces your application have all interfaces in d-feet.

> Regards,
> Anitha
>
> ________________________________
>
> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, propri=
etary or legally privileged information. In case you are not the original i=
ntended Recipient of the message, you must not, directly or indirectly, use=
, disclose, distribute, print, or copy any part of this message and you are=
 requested to delete it and inform the sender. Any views expressed in this =
message are those of the individual sender unless otherwise stated. Nothing=
 contained in this message shall be construed as an offer or acceptance of =
any offer by Sasken Technologies Limited ( formerly known as "Sasken Commun=
ication Technologies Limited" ) unless sent with that express intent and wi=
th due authority of Sasken. Sasken has taken enough precautions to prevent =
the spread of viruses. However the company accepts no liability for any dam=
age caused by any virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/mail-disclaimer/
>
> ________________________________
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
