Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4A78C77
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195617; cv=none; b=rPIEOAklginDxtpkN2CcpKUUbIxcZzEaq6KuAdGI8J2Jg2qj1Kn5N5Fne4qek5KT4DreSzA0dfAAGbzfm3nNXdIolVqiJEpQ+bn8h+aCBKsDU0djByiDwTCWi+fs2zNgFhKMMriGtyNr1XgPgf3vrvDnTFfekkwHpsxKXLJ71FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195617; c=relaxed/simple;
	bh=jZyvmZnRydCJOoVt3gmE+y6KHhkY/gX1aPFrxiTs86M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9vnhs1XLJe2c3779QUI64uQ2GCdhLa4zMt3vFowWjoV8Ze7YMNURT2gl2Jo9H3NuGnpKFb5PuH6N0agwfCQBrQu3vhpBQ3vFMNiamsoYng7kyTW2JWG2FIV/1dB/8woIgBh19VJKrqgx7A3OOZ0onp9sPJNKGq7pwogHsXVc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiYOGP9c; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiYOGP9c"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2da68af6c6fso17022891fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713195614; x=1713800414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rabRSDRGz2ka0OSKSPVR7Njpy9wM18fSoKOnRfgaEMI=;
        b=iiYOGP9cKQ21QnRHsPJMXzuFvHQF4Sa3iNEmmvfMzyoptBlUxougt503Dnkq3ks+qN
         0PkyhOmlk2zysjVwUO8+9zs2CWBcOeq8HCaOJ7ubAGtL4JadhAqnLYfO0IWqFqco0vqq
         IoZcJ7eTnbTabdex/JTFsULGLNMApwbrpjfgJcd0lK8j40GlQR5fA/3wouusnLzbdWRq
         krAvRJT4/3Pu+dYV5XtdkO/grq3r5NOq7/DbLc25scu4DBwMKymhvs2HxoAVcMgWCATq
         1Mp49cOqjS2pg4TdmG0YQ2g3OSWFogV8DDkJVDmgR1AwFW+cDP/ULLVFYCl+gzFaK9VC
         NQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195614; x=1713800414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rabRSDRGz2ka0OSKSPVR7Njpy9wM18fSoKOnRfgaEMI=;
        b=VPrEOO6QNxm5NIGlUa91qEByge6QsUNDMHkxT/DWx5w7pPIYyLtnu54pA97Hzim41J
         A36ynrpbHmpLClOo0XRRWFsCNfdxGuK4Z6chDVlsX6VfYf6/x7jTr53H3dB2HQ0zVwG0
         zpb+Y3Og8XKX4RV8v8+S2IRbJFsNh7Z7sSDj5zHBLoEzWnRIo6wv2u3/nr40LBLWnXCw
         T2cUUeXALzEPVEhz1Ts4v/zCP/sjlYAW/pUaksILEgU6atCV0alf91BAmt9fsCYsdosk
         LFTlhs/tZHEZOOR3n6ZsuNli1wAy7m3q7bQIANJLS+LgWAaQlQdKD92Y7xYIa0nf0Kd0
         7Xkw==
X-Gm-Message-State: AOJu0Yy2OP8glhhPw8cAvPW41umB6gkejAv371ceW+HA6x2obIgCi8fF
	wxOQ/u9EQUf4D3iiJLYP6mQEcSw/dIBRDQVC5yx5Pg6UDKPwagBKpXAqdCAXH0wker4p8G66Zss
	Gu9sn6cY67oHof9hUm5VrfDeRoG0=
X-Google-Smtp-Source: AGHT+IE83yhWUXTEFfTpDIu7ZfmaKACs2ZolsG2a0uFrr7t5qO2SZLyJpNGGHjn4qdjNoDwdEDN7+PQLUFoI+/b+ESU=
X-Received: by 2002:a05:651c:205:b0:2da:78fc:6418 with SMTP id
 y5-20020a05651c020500b002da78fc6418mr1938217ljn.19.1713195613831; Mon, 15 Apr
 2024 08:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PAXPR08MB6399418D53ED76246B32164998092@PAXPR08MB6399.eurprd08.prod.outlook.com>
 <PAXPR08MB639971AE2D6FB75937F92D2C98092@PAXPR08MB6399.eurprd08.prod.outlook.com>
In-Reply-To: <PAXPR08MB639971AE2D6FB75937F92D2C98092@PAXPR08MB6399.eurprd08.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Apr 2024 11:40:00 -0400
Message-ID: <CABBYNZ+0XmS5EYmoEKXzRxFHJEoGsTj8ghmVreX9VSt3tTymrg@mail.gmail.com>
Subject: Re: Bluetooth from Windows to Linux using BlueZ
To: Peter Mortier <peter.mortier@outlook.be>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Apr 15, 2024 at 11:19=E2=80=AFAM Peter Mortier <peter.mortier@outlo=
ok.be> wrote:
>
> Dear all,
> I want to set up a simple bluetooth connection between 2 PC=E2=80=99s, cl=
ient running Windows and server running Linux.
> There is no need for a lot of overhead such as pairing.
> I am running the server software on Linux Ubuntu with the following code:
>
>     int serverSocket, clientSocket;
>     struct sockaddr_rc serverAddr =3D {0}, clientAddr=3D{0};
>
>     socklen_t clientAddrSize =3D sizeof(sockaddr_rc);
>
>     // Create Bluetooth socket
>     serverSocket=3Dsocket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>     if (serverSocket<0)
>     {
>       perror("socket creation failed: ");
>       return false;
>     }
>     bdaddr_t  bdaddr_any=3D{{0,0,0,0,0,0}};
>
>   // Bind the socket to any local Bluetooth adapter
>     serverAddr.rc_family =3D AF_BLUETOOTH;
>     serverAddr.rc_bdaddr =3D bdaddr_any; // bind to any local Bluetooth a=
dapter
>     serverAddr.rc_channel =3D 25;
>
>     if (bind(serverSocket,(struct sockaddr*)&serverAddr,sizeof(serverAddr=
))<0)
>     {
>       perror("Bind failed");
>       close(serverSocket);
>       exit(EXIT_FAILURE);
>     }
>
>     // listen for incoming connections
>     if (listen(serverSocket,1) <0)
>     {
>       perror("Listen failed");
>       close(serverSocket);
>       exit(EXIT_FAILURE);
>     };
>
>     while (true)
>     {
>       wxPrintf("Waiting for incoming Bluetooth connections...\n");
>
>       // Accept incoming connection
>       clientSocket =3D accept(serverSocket, (struct sockaddr*) &clientAdd=
r,&clientAddrSize);
>       if (clientSocket<0)
>       {
>         perror("accept failed");
>         continue;
>       }
>
> I am running the client software on Windows 10 with the following code:
>
>     // Create a Bluetooth socket
>     m_serverSocket =3D socket(AF_BTH, SOCK_STREAM, BTHPROTO_RFCOMM);
>     SOCKADDR_BTH serverAddr =3D { 0 };
>     if (m_serverSocket =3D=3D INVALID_SOCKET) {
>       return false;
>     }
>
>     // Set the address of the remote Bluetooth device to connect to
>     serverAddr.addressFamily =3D AF_BTH;
>     serverAddr.btAddr =3D *reinterpret_cast<BTH_ADDR*>(&m_Server.Address.=
ullLong); // this is the addres found by function BluetoothFindFirstDevice(=
)
>     serverAddr.serviceClassId =3D RFCOMM_PROTOCOL_UUID;  // I also tried =
GUID_NULL
>     serverAddr.port =3D 25; // I also tried 0
>
>     // Connect to the remote Bluetooth device
>     if (connect(m_serverSocket, reinterpret_cast<SOCKADDR*>(&serverAddr),=
 sizeof(serverAddr)) =3D=3D SOCKET_ERROR) {
>        std::cout << "error: " << WSAGeLastError() << std::endl;
>       return false;
>     }
>
> The Linux server is listening on port 25 while the Windows client tries t=
o connect to the same port. The client first searches for the server with B=
luetoothFindFirstDevice and BluetoothFindNextDevice, finds the server bluet=
oooth address and uses that address to connect.
> The connection on the client then fails with error code 10051 (or sometim=
es 10060)
>
> On Linux there is no firewall installed, using bluetoothclt I see it is r=
egistered and pairable. The bluetooth dongle is plugged into a USB port and=
 is seen as USB2.0-BT. I have tried different ports without success.
>
> I've done some testing with my code. It seems bluetooth is working well w=
ith code above in the following circumstances :
> - windows =E2=86=92 windows
> - linux =E2=86=92 linux
> - linux =E2=86=92 windows
> The only thing that doesn't work is: windows =E2=86=92 linux
>
> I am told the problem lies in the BlueZ library, but I find this hard to =
believe. My guesses are I am doing something wrong.

We probably need to HCI trace to tell what is going on, no idea what
are the errors that windows stack is throwing, besides if you manage
to connect Linux to Linux I assume the server is listening, but
perhaps  there is a different problem, anyway I would recommend using
rctest instead before attempting to write your own version of it:

https://github.com/bluez/bluez/blob/master/tools/rctest.rst

> Any help is much appreciated!
>
> Best regards,
> Peter



--=20
Luiz Augusto von Dentz
