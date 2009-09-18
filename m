Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2009 07:19:23 -0400
Message-ID: <c1d79cc40909180419t45198d46h91b06ca20383fc12@mail.gmail.com>
Subject: Help
From: Lorenzo Brito Morales <lorenzo.brito@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, im a beggineer in bluez and also in programming stuff, i have read
a coupble of things about bluez and programming,  what i want to do is
a progran that send files to the phone is near by,,im trying to get
work these code, its compile, and conect to the phone , but in the
phone ask for a number security, ahta later i have to type in the
computer...... how can i send a file whitout asking a number? just
asking in the phone about aceptting the file
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

int main(int argc, char **argv)
{
    struct sockaddr_rc addr = { 0 };
    int s, status;
    char dest[18] = "00:23:F1:CC:BF:10";

    // allocate a socket
    s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    // set the connection parameters (who to connect to)
    addr.rc_family = AF_BLUETOOTH;
    addr.rc_channel = 1;
    str2ba( dest, &addr.rc_bdaddr );

    // connect to server
    status = connect(s, (struct sockaddr *)&addr, sizeof(addr));

    // send a message
    if( 0 == status ) {
        status = send(s, "hello!", 6, 0);
    }

    if( status < 0 ) perror("uh oh");

    close(s);
    return 0;
}
