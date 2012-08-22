Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <503568C5.4040000@globaledgesoft.com>
References: <503545C5.80607@globaledgesoft.com>
	<CAJdJm_NHy82UOofuQv1jGObJPg4MOj68R3D_xcBjNhCZWdy9Hw@mail.gmail.com>
	<503568C5.4040000@globaledgesoft.com>
Date: Wed, 22 Aug 2012 12:01:09 -0400
Message-ID: <CAJdJm_NkobxyO=Ks=hdMxNjHNb1jSMotNPCcLrtwq+bjKxkJYw@mail.gmail.com>
Subject: Re: Re : BLE -Multiple connection
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay KV <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Wed, Aug 22, 2012 at 7:18 PM, Ajay KV <ajay.kv@globaledgesoft.com> wrote:
>         First of all, sorry for my ignorance . Following are the steps i did
> in my test case.  i am also using dual mode dongles , so as you said  spec
> is not allowing us to do  this operation
> [snip]

I remembered that the Core spec mentions that it is not required for a
controller to support more than one connection. Maybe it is the case
for the dongles you have? In this case, the controller will not allow
to send connectable advertising because of the active connection.

(sorry, I could not find the section of the spec that mentions this)

If you close the connection, are you able to run "hciconfig hci0
leadv" again on "A"?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
