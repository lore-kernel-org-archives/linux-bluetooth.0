Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] API for MAP client in obex-client
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Thu, 03 Nov 2011 15:08:19 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
In-Reply-To: <CAPGrrxXkvaNjnUT9vJ8sdnHuabF7zwtWnOnnbLD1+G0huvj1xw@mail.gmail.com>
References: <CAPGrrxXkvaNjnUT9vJ8sdnHuabF7zwtWnOnnbLD1+G0huvj1xw@mail.gmail.com>
Message-ID: <ca9f11c3ddb562558c25a7ff185407ad@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 03.11.2011 14:44, schrieb Bartosz Szatkowski:
>                void SetFolder(boolean cdup, string name)
>
>                        Set working directory for current session.
>
>                        |  cdup  | folder name | operation    |
>                        |=====================================|
>                        | FALSE  | empty       | cd /         |
>                        |--------+-------------+--------------|
>                        | FALSE  | name        | cd name      |
>                        |--------+-------------+--------------|
>                        | TRUE   | [name]      | cd ..[/name] |
>                        +-------------------------------------+

Why not simply
   void SetFolder(String cdString)

and derive the obex command from that? It makes that API much easier to 
use.

HS

